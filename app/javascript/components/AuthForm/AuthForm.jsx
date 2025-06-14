import React, { useState } from "react";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';  
import Col from 'react-bootstrap/Col';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import Image from 'react-bootstrap/Image';
import Logo from "../../../assets/images/logo.png";
import axios from '../../services/axios';

const AuthForm = ({ authAction }) => {
    const [emailInput, setEmailInput] = useState('');
    const [passwordInput, setPasswordInput] = useState('');
    const [zipCodeInput, setZipCodeInput] = useState('');

    const handleSubmit = async (e) => {
      e.preventDefault();
  
      try {
        const url = authAction === 'Sign Up' ? '/signup' : '/login';

        await axios.post(url, {
          user: {
            email: emailInput,
            password: passwordInput,
            zip_code: zipCodeInput
          }
        });
  
        window.location.reload();
      } catch (error) {
        window.location.reload();
      }
  };

    return (
        <Container>
          <Row className="justify-content-md-center">
            <Col xs={12} md={8} lg={4}>
              <h1>
                  <span className="text-inline">{ authAction } to
                  <Image
                      alt={`${authAction} Logo`}
                      src={Logo}
                      width="100"
                      height="40"
                      className="d-inline-block align-text-top"
                  />{' '}
                  </span>
              </h1>
              <Form onSubmit={handleSubmit}>
                  <Form.Group className="mb-3" controlId="formBasicEmail">
                      <Form.Label>Email</Form.Label>
                      <Form.Control
                          type="email"
                          placeholder="attendee@example.com"
                          required
                          autoComplete="email"
                          value={emailInput}
                          onChange={(e) => setEmailInput(e.target.value)}
                      />
                  </Form.Group>

                  <Form.Group className="mb-3" controlId="formBasicPassword">
                      <Form.Label>Password</Form.Label>
                      <Form.Control
                          type="password"
                          placeholder="********"
                          required
                          autoComplete="current-password"
                          value={passwordInput}
                          onChange={(e) => setPasswordInput(e.target.value)}
                      />
                  </Form.Group>

                  <Form.Group className="mb-3" controlId="formBasicZipCode">
                      <Form.Label>Zip Code</Form.Label>
                      <Form.Control
                          type="zipcode"
                          placeholder="12345"
                          required
                          autoComplete="zip-code"
                          value={zipCodeInput}
                          onChange={(e) => setZipCodeInput(e.target.value)}
                      />
                  </Form.Group>

                  <Button variant="primary" type="submit">
                      { authAction }
                  </Button>
              </Form>
            </Col>
          </Row>
        </Container>
    );
};

export default AuthForm;