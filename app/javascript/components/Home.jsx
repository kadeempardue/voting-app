import React from "react";
import Wrapper from './Wrapper';
import AuthForm from "./AuthForm/AuthForm";

const Home = () => {
  return (
    <Wrapper>
      <AuthForm authAction="Sign In" />
    </Wrapper>
  );
};

export default Home;
