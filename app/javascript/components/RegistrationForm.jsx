import React from "react";
import Wrapper from './Wrapper';
import AuthForm from "./AuthForm/AuthForm";

const RegistrationForm = ({ user }) => {
  return (
    <Wrapper>
      <AuthForm authAction="Sign Up" />
    </Wrapper>
  );
};

export default RegistrationForm;
