import React from "react";
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import NavDropdown from 'react-bootstrap/NavDropdown';
import Badge from 'react-bootstrap/Badge';
import Image from 'react-bootstrap/Image';
import Logo from "../../../assets/images/logo.png";
import axios from '../../services/axios';

const Header = ({ loggedIn = false, votingBoothInUse = false, userEmail = "" }) => {
  const handleDelete = async (e) => {
    e.preventDefault();

    try {
      await axios.delete('/logout');
      window.location.href = '/';
    } catch (error) {
      window.location.reload();
    }
  };

  return (
    <>
        <Navbar bg="dark" variant="dark" expand="lg">
            <Navbar.Brand href="/">
            <Image
                alt="Header Logo"
                src={Logo}
                width="50"
                height="20"
                className="d-inline-block align-text-top"
            />{' '}
            Music Festival
            </Navbar.Brand>
            <Navbar.Toggle aria-controls="basic-navbar-nav" />
            <Navbar.Collapse id="basic-navbar-nav">
                <Nav className="mr-auto">
                <Nav.Link href="/votes" className={window.location.pathname === "/votes" ? "text-white" : ""}>Results</Nav.Link>
                <NavDropdown title="Voting Booth" id="basic-nav-dropdown">
                    <NavDropdown.Item href="/voting_booth">
                    Vote for a Candidate
                    </NavDropdown.Item>
                </NavDropdown>
                </Nav>
                <Badge className="mr-2" variant={votingBoothInUse ? "danger" : "success"}>{votingBoothInUse ? "Voting Booth In Use" : "Voting Booth Open"}</Badge>
                {!loggedIn && (
                  <Nav.Link href="/signup" className="mr-2 btn btn-link btn-secondary text-white">Sign Up</Nav.Link>
                )}
                {loggedIn && (
                  <>
                  <span className="text-white mr-2">{userEmail}</span>
                  <Nav.Link href="/logout" className="mr-2 btn btn-link btn-primary text-white" variant="outline-primary" onClick={handleDelete}>Logout</Nav.Link>
                  </>

                )}
            </Navbar.Collapse>
        </Navbar>
    </>
  );
};

export default Header;
