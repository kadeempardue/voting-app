import React from "react";
import Navbar from 'react-bootstrap/Navbar';

import Image from 'react-bootstrap/Image';
import Logo from "../../../assets/images/logo.png";

const Footer = () => {
  const heighAbove576 = window.innerHeight > 576;

  return (
    <>
      <Navbar bg="dark" variant="dark" fixed={heighAbove576 ? "bottom" : undefined}>
          <Navbar.Brand href="/">
          <Image
              alt="Footer Logo"
              src={Logo}
              width="50"
              height="20"
              className="d-inline-block align-text-top"
          />
          </Navbar.Brand>
      </Navbar>
    </>
  );
};

export default Footer;
