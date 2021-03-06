/**
 *
 * RegisterPage
 *
 */

import React, { Fragment, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { Helmet } from 'react-helmet';
import { FormattedMessage } from 'react-intl';
import { useInjectSaga } from 'utils/injectSaga';
import { useInjectReducer } from 'utils/injectReducer';
import reducer from './reducer';
import saga from './saga';

// Import Components
import Header from 'components/Header';
import Subheader from 'components/Subheader';
import Information from 'components/Information';
import RegisterForm from 'components/RegisterForm';
import Footer from 'components/Footer';
import Notifier from 'components/Notifier';
import messages from './messages';

// Import Actions
import { loadCurrencyAction, isLoggedAction } from './actions';

const key = 'registerPage';

export default function RegisterPage() {
  const dispatch = useDispatch();
  const isLogged = () => dispatch(isLoggedAction());
  const getCurrency = () => dispatch(loadCurrencyAction());

  useInjectReducer({ key, reducer });
  useInjectSaga({ key, saga });

  useEffect(() => {
    isLogged();
    getCurrency();
  }, []);

  return (
    <Fragment>
      <FormattedMessage {...messages.helmetRegisterTitle}>
        {title => <Helmet title={title} />}
      </FormattedMessage>

      <Header />
      <FormattedMessage {...messages.registerText}>
        {title => <Subheader title={title} />}
      </FormattedMessage>

      <Information />
      <RegisterForm />
      <Footer />
      <Notifier />
    </Fragment>
  );
}
