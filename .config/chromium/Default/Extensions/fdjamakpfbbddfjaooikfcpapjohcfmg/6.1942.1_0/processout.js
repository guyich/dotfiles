// Processout data and tokens
let processout;
let processOutForm;
let customerId;
let tokenId;

// Form Fields
let fields;
let paymentState = {
  card: false,
  month: false,
  year: false,
  cvc: false,
  name: false,
  address: false,
  city: false,
  zip: false,
};

// Error Dom Elements
let declinedErrorDomEl;
let formErrorDomEl;

// DOM Classes
const IS_SELECTED = 'isSelected';
const WITH_ERROR = 'withError';

/**
 * Messaging
 */

function postMessageToLeeloo(event, action, cardId, customerId) {
  event.source.postMessage(
    {
      messageType: 'PROCESSOUT_TO_LEELOO',
      action,
      cardId,
      customerId,
    },
    event.origin
  );
}

function messageReceivedFromLeeloo(event) {
  if (event.data.messageType !== 'LEELOO_TO_PROCESSOUT') {
    return;
  }

  switch (event.data.action) {
    case 'INIT':
      initForm(event);
      break;
    case 'SUBMIT':
      submitForm(event);
      break;
    case 'GET_CARD_TOKEN':
      getCardToken(event);
      break;
    case 'MAKE_PAYMENT':
      makePayment(event);
      break;
  }
}

window.addEventListener('message', messageReceivedFromLeeloo, false);

/**
 * Actions
 */

function initForm(event) {
  const { apiKey } = event.data;
  const {
    countries,
    translations,
    errors,
    countriesStates,
    style,
  } = event.data.data;
  if (event.data.card) {
    customerId = event.data.card.customerId;
    tokenId = event.data.card.tokenId;
  }

  // Init form, get dom elements, setup translations
  initFormFields();
  initCountries(countries, countriesStates);
  initCustomStyle(style);
  initTranslations(translations, errors);

  // Setup ProcessOut
  setupProcessOut(event, apiKey);
  setupInputFieldValdiaton();
}

function setupProcessOut(event, apiKey) {
  processout = new ProcessOut.ProcessOut(apiKey);
  const formElement = document.getElementById('card-form');
  const formStyle = {
    fontSize: '14px',
    lineHeight: '18px',
    color: '#474747',
    fontFamily:
      '"Source Sans Pro", Helvetica, Arial, "Lucida Grande", sans-serif',
    '::placeholder': {
      color: '#777',
    },
  };

  processout.setupForm(
    formElement,
    formStyle,
    form => {
      processOutForm = form;

      // Store PO fields on our field objects
      fields.creditCard.poField = processOutForm.getNumberField();
      fields.expirationMonth.poField = processOutForm.getExpiryMonthField();
      fields.expirationYear.poField = processOutForm.getExpiryYearField();
      fields.cvc.poField = processOutForm.getCVCField();

      // Setup focus/blur
      Object.keys(fields)
        .map(fieldName => fields[fieldName])
        .filter(field => field.type === 'processout')
        .forEach(field => {
          field.poField.on('focus', () => {
            field.input.classList.add(IS_SELECTED);
            field.baseline.classList.add(IS_SELECTED);
          });
          field.poField.on('blur', () => {
            field.input.classList.remove(IS_SELECTED);
            field.baseline.classList.remove(IS_SELECTED);
          });
        });

      // Setup validation handling
      fields.creditCard.poField.on('input', card => {
        clearValidation(fields.creditCard);
        !card.valid ? (paymentState.card = false) : (paymentState.card = true);
      });
      fields.expirationMonth.poField.on('input', month => {
        clearValidation(fields.expirationMonth);
        isMonthPotentiallyValid(month)
          ? (paymentState.month = false)
          : (paymentState.month = true);
      });
      fields.expirationYear.poField.on('input', year => {
        clearValidation(fields.expirationYear);
        isYearPotentiallyValid(year)
          ? (paymentState.year = false)
          : (paymentState.year = true);
      });
      fields.cvc.poField.on('input', cvc => {
        clearValidation(fields.cvc);
        !cvc.valid || cvc.empty
          ? (paymentState.cvc = false)
          : (paymentState.cvc = true);
      });

      postMessageToLeeloo(event, 'INIT_SUCCESSFUL');
    },
    function(err) {
      postMessageToLeeloo(event, 'INIT_FAILED');
    }
  );
}

function setupInputFieldValdiaton() {
  Object.keys(fields)
    .map(fieldName => fields[fieldName])
    .filter(field => field.type === 'input')
    .forEach(field => {
      field.input.addEventListener('focus', () => {
        field.input.classList.add(IS_SELECTED);
        field.baseline.classList.add(IS_SELECTED);
      });
      field.input.addEventListener('blur', () => {
        field.input.classList.remove(IS_SELECTED);
        field.baseline.classList.remove(IS_SELECTED);
      });
      field.input.addEventListener('input', () => {
        clearValidation(field);
      });
    });

  // Validation
  fields.name.input.addEventListener('change', event => {
    event.target.value !== ''
      ? (paymentState.name = true)
      : (paymentState.name = false);
  });
  fields.address.input.addEventListener('change', event => {
    event.target.value !== ''
      ? (paymentState.address = true)
      : (paymentState.address = false);
  });
  fields.city.input.addEventListener('change', event => {
    event.target.value !== ''
      ? (paymentState.city = true)
      : (paymentState.city = false);
  });
  fields.zip.input.addEventListener('change', event => {
    event.target.value !== ''
      ? (paymentState.zip = true)
      : (paymentState.zip = false);
  });
}

function submitForm(event) {
  if (Object.keys(paymentState).some(i => !paymentState[i])) {
    showValidationErrors();
  } else {
    processout.tokenize(
      processOutForm,
      getFormValues(),
      function(cardId) {
        processout.makeCardToken(
          cardId,
          customerId,
          tokenId,
          getFormValues(),
          function(token) {
            postMessageToLeeloo(event, 'TOKENIZE', cardId, customerId);
          },
          function(error) {
            handleProcessOutErrors(event, error);
          }
        );
      },
      function(error) {
        handleProcessOutErrors(event, error);
      }
    );
  }
}

function getCardToken(event) {
  if (Object.keys(paymentState).some(i => !paymentState[i])) {
    showValidationErrors();
  } else {
    processout.tokenize(
      processOutForm,
      getFormValues(),
      function(cardId) {
        postMessageToLeeloo(event, 'TOKENIZE', cardId);
      },
      function(error) {
        handleProcessOutErrors(event, error);
      }
    );
  }
}

function makePayment(event) {
  if (Object.keys(paymentState).some(i => !paymentState[i])) {
    showValidationErrors();
  } else {
    const { invoiceId, customerId } = event.data;

    processout.makeCardPayment(
      invoiceId,
      customerId,
      { authorize_only: true },
      function(poInvoiceId) {
        postMessageToLeeloo(event, 'INVOICEID', poInvoiceId);
      },
      function(error) {
        handleProcessOutErrors(event, error);
      }
    );
  }
}

/**
 * Error Handling and Validation
 */

function handleProcessOutErrors(event, err) {
  switch (err.code) {
    case 'card.declined':
      // The card was declined, a new one should be submitted
      showFormError(declinedErrorDomEl.innerHTML);
      break;
    case 'card.expired':
      // The card is expired, a new one should be submitted
      fields.expirationMonth.error.setAttribute('style', '');
      fields.expirationMonth.baseline.classList.add(WITH_ERROR);
      fields.expirationMonth.input.classList.add(WITH_ERROR);
      fields.expirationYear.input.classList.add(WITH_ERROR);
      break;
    case 'card.invalid':
      // The card is invalid
      showFormError(err.message);
      break;
    case 'card.invalid-number':
      // The card number is invalid
      showFormError(err.message);
      break;
    case ('card.invalid-date', 'card.invalid-month', 'card.invalid-year'):
      // The card expiration date is invalid
      fields.expirationMonth.error.setAttribute('style', '');
      fields.expirationMonth.baseline.classList.add(WITH_ERROR);
      fields.expirationMonth.input.classList.add(WITH_ERROR);
      fields.expirationYear.input.classList.add(WITH_ERROR);
      break;
    case 'card.invalid-cvc':
      // The card CVC is invalid
      fields.cvc.error.setAttribute('style', '');
      fields.cvc.baseline.classList.add(WITH_ERROR);
      fields.cvc.input.classList.add(WITH_ERROR);
      break;
    default:
      // Another less common error was thrown
      showFormError(err.message);
  }

  postMessageToLeeloo(event, 'PROCESSOUT_FAILURE');
}

function showFormError(errorMessage) {
  formErrorDomEl.setAttribute('style', '');
  formErrorDomEl.innerHTML = errorMessage;
}

function showValidationErrors() {
  if (!paymentState.card) {
    fields.creditCard.error.setAttribute('style', '');
    fields.creditCard.baseline.classList.add(WITH_ERROR);
    fields.creditCard.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.month || !paymentState.year) {
    fields.expirationMonth.error.setAttribute('style', '');
    fields.expirationMonth.baseline.classList.add(WITH_ERROR);
    fields.expirationMonth.input.classList.add(WITH_ERROR);
    fields.expirationYear.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.cvc) {
    fields.cvc.error.setAttribute('style', '');
    fields.cvc.baseline.classList.add(WITH_ERROR);
    fields.cvc.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.name) {
    fields.name.error.setAttribute('style', '');
    fields.name.baseline.classList.add(WITH_ERROR);
    fields.name.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.address) {
    fields.address.error.setAttribute('style', '');
    fields.address.baseline.classList.add(WITH_ERROR);
    fields.address.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.city) {
    fields.city.error.setAttribute('style', '');
    fields.city.baseline.classList.add(WITH_ERROR);
    fields.city.input.classList.add(WITH_ERROR);
  }
  if (!paymentState.zip) {
    fields.zip.error.setAttribute('style', '');
    fields.zip.baseline.classList.add(WITH_ERROR);
    fields.zip.input.classList.add(WITH_ERROR);
  }

  postMessageToLeeloo(event, 'PROCESSOUT_FAILURE');
}

/**
 * Initialization
 */

function initFormFields() {
  fields = {
    creditCard: {
      type: 'processout',
      label: document.getElementById('label-card'),
      labelTranslation: 'creditCardNumber',
      input: document.getElementById('cc-wrapper'),
      baseline: document.getElementById('cc-baseline'),
      error: document.getElementById('card-error'),
      errorTranslation: 'creditCardError',
    },
    expirationMonth: {
      type: 'processout',
      label: document.getElementById('label-date'),
      labelTranslation: 'expirationDate',
      input: document.getElementById('month-wrapper'),
      baseline: document.getElementById('month-baseline'),
      error: document.getElementById('expiry-error'),
      errorTranslation: 'expirationError',
    },
    expirationYear: {
      type: 'processout',
      label: document.getElementById('label-date'),
      labelTranslation: 'expirationDate',
      input: document.getElementById('year-wrapper'),
      baseline: document.getElementById('year-baseline'),
      error: document.getElementById('expiry-error'),
      errorTranslation: 'expirationError',
    },
    cvc: {
      type: 'processout',
      label: document.getElementById('label-code'),
      labelTranslation: 'securityCode',
      input: document.getElementById('cvc-wrapper'),
      baseline: document.getElementById('cvc-baseline'),
      error: document.getElementById('code-error'),
      errorTranslation: 'securityError',
    },
    name: {
      type: 'input',
      label: document.getElementById('label-name'),
      labelTranslation: 'cardHolderName',
      input: document.getElementById('cardholdername'),
      baseline: document.getElementById('name-baseline'),
      error: document.getElementById('name-error'),
      errorTranslation: 'cardHolderError',
    },
    address: {
      type: 'input',
      label: document.getElementById('label-address'),
      labelTranslation: 'address',
      input: document.getElementById('cardholderaddress'),
      baseline: document.getElementById('address-baseline'),
      error: document.getElementById('address-error'),
      errorTranslation: 'addressError',
    },
    city: {
      type: 'input',
      label: document.getElementById('label-city'),
      labelTranslation: 'city',
      input: document.getElementById('cardholdercity'),
      baseline: document.getElementById('city-baseline'),
      error: document.getElementById('city-error'),
      errorTranslation: 'cityError',
    },
    zip: {
      type: 'input',
      label: document.getElementById('label-zip'),
      labelTranslation: 'zipCode',
      input: document.getElementById('cardholderzip'),
      baseline: document.getElementById('zip-baseline'),
      error: document.getElementById('zip-error'),
      errorTranslation: 'zipCodeError',
    },
    country: {
      type: 'select',
      label: document.getElementById('label-country'),
      labelTranslation: 'country',
      input: document.getElementById('cardholdercountry'),
      baseline: document.getElementById('country-baseline'),
      error: document.getElementById('country-error'),
      errorTranslation: undefined,
    },
    country: {
      type: 'select',
      label: document.getElementById('label-country'),
      labelTranslation: 'country',
      input: document.getElementById('cardholdercountry'),
      baseline: document.getElementById('country-baseline'),
      error: undefined, // No country-specific errors
      errorTranslation: undefined, // No country-specific errors
    },
    state: {
      type: 'select',
      label: document.getElementById('label-country-state'),
      labelTranslation: 'state',
      input: document.getElementById('cardholderstate'),
      baseline: document.getElementById('state-baseline'),
      error: undefined, // No country-specific errors
      errorTranslation: undefined, // No country-specific errors
    },
  };

  formErrorDomEl = document.getElementById('form-error');

  declinedErrorDomEl = document.getElementById('declined-error');
}

function initCountries(countries, states) {
  // Add country elements, default to US
  const countriesElementsString = Object.keys(countries)
    .map(key => {
      const isSelected = key === 'US' ? 'selected' : '';
      return `<option value="${key}" ${isSelected}>${countries[key]}</option>`;
    })
    .join('');
  fields.country.input.innerHTML = countriesElementsString;

  // Add state elements, default to US
  addStatesToDom(states['US']);

  // Hide/show states based on country, and load selected country's states
  const stateContainer = document.getElementById('country-state-container');
  fields.country.input.addEventListener('change', event => {
    if (states[event.target.value]) {
      addStatesToDom(states[event.target.value]);
      stateContainer.classList.remove('hidden');
    } else {
      addStatesToDom([]);
      stateContainer.classList.add('hidden');
    }
  });
}

function initCustomStyle(style) {
  if (style === undefined) {
    return;
  }

  document.body.classList.add(style);
}

function initTranslations(labels, errors) {
  const ellipsis = '...';

  // Translate Labels
  Object.keys(fields)
    .map(fieldName => fields[fieldName])
    .filter(
      field =>
        field.label && field.labelTranslation && labels[field.labelTranslation]
    )
    .forEach(field => {
      field.label.innerHTML = labels[field.labelTranslation];
    });

  // Translate Placeholders
  Object.keys(fields)
    .map(fieldName => fields[fieldName])
    .filter(field => field.type === 'input')
    .filter(
      field =>
        field.label && field.labelTranslation && labels[field.labelTranslation]
    )
    .forEach(field => {
      field.input.placeholder = `${labels[field.labelTranslation]}${ellipsis}`;
    });

  // Translate Errors
  Object.keys(fields)
    .map(fieldName => fields[fieldName])
    .filter(
      field =>
        field.error && field.errorTranslation && errors[field.errorTranslation]
    )
    .forEach(field => {
      field.error.innerHTML = errors[field.errorTranslation];
    });
}

/**
 * Helpers
 */

function clearValidation(field) {
  if (field.error) {
    field.error.setAttribute('style', 'display:none;');
  }

  if (field.baseline) {
    field.baseline.classList.remove(WITH_ERROR);
  }

  if (field.input) {
    field.input.classList.remove(WITH_ERROR);

    if (field === fields.expirationMonth) {
      fields.expirationYear.input.classList.remove(WITH_ERROR);
    } else if (field === fields.expirationYear) {
      fields.expirationMonth.input.classList.remove(WITH_ERROR);
    }
  }

  formErrorDomEl.setAttribute('style', 'display:none;');
  formErrorDomEl.innerHTML = '';
}

function isMonthPotentiallyValid(month) {
  return month >= 1 && month <= 12;
}

function isYearPotentiallyValid(year) {
  return (
    (/^\d{2}$/.test(`${year}`) || /^\d{4}$/.test(`${year}`)) &&
    moment()
      .year(year)
      .year() >= moment().year()
  );
}

function addStatesToDom(states) {
  const statesElementsString = Object.keys(states)
    .map(key => `<option value="${key}">${states[key]}</option>`)
    .join('');
  fields.state.input.innerHTML = statesElementsString;
}

function getFormValues() {
  return {
    name: fields.name.input.value,
    contact: {
      address1: fields.address.input.value,
      city: fields.city.input.value,
      state: fields.state.input.value || undefined, // undefined for countries with no states
      country_code: fields.country.input.value,
      zip: fields.zip.input.value,
    },
  };
}
