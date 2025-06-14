import React from "react";
import Container from 'react-bootstrap/Container';
import 'bootstrap/dist/css/bootstrap.min.css';

const Wrapper = ({ children, alert }) => {
  return (
    <Container className=" pb-5 px-0 container">
      {children}
    </Container>
  );
};

export default Wrapper;
