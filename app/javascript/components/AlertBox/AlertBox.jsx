import React from "react";
import Alert from 'react-bootstrap/Alert';

const AlertBox = ({ idx, variant = "primary", message = "This is a primary alert—check it out!" }) => {
  return (
    <>
      <Alert key={idx} variant={variant}>
        {message}
      </Alert> 
    </>
  );
};

export default AlertBox;
