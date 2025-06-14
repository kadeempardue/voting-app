import React, { useState, useRef } from "react";
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import axios from '../../services/axios';

const VotingForm = ({ candidates = [] }) => {
  const [writeInCandidate, setWriteInCandidate] = useState(null);
  const [selectedCandidate, setSelectedCandidate] = useState(null);

  const checkRefs = useRef({});
  const writeInRef = useRef();

  const handleDelete = async (e) => {
    e.preventDefault();

    try {
      await axios.delete('/logout');
      window.location.href = '/';
    } catch (error) {
      window.location.reload();
    }
  };

  const clearCheck = (selectedCandidate) => {
    if (checkRefs.current[selectedCandidate]) {
      checkRefs.current[selectedCandidate].checked = false;
    }
  };

  const handleCandidateChange = (e) => {
    setWriteInCandidate(null);
    setSelectedCandidate(e.target.value);
    if (writeInRef.current) {
      writeInRef.current.value = "";
    }
  };

  const handleWriteInChange = (e) => {
    setSelectedCandidate(null);
    setWriteInCandidate(e.target.value);
    clearCheck(selectedCandidate);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      let vote_params = {};
      if (selectedCandidate) {
        vote_params.election_id = selectedCandidate;
      } else if (writeInCandidate) {
        vote_params.election_attributes = {
          name: writeInCandidate,
        }
      }
      await axios.post('/votes', {vote: vote_params});
      window.location.href = '/votes';
    } catch (error) {
      window.location.reload();
    }
};

  return (
    <Form onSubmit={handleSubmit}>
      {candidates.length > 0 && (
        <>
          <Form.Group className="mt-4" controlId="votingForm.candidateSelect">
            <Form.Label className="mb-3">Select Candidate To Vote For:</Form.Label>
            { candidates.map((candidate) => (
              <div key={candidate.id}>
                <Form.Check 
                  type='radio'
                  id={candidate.id}
                  label={candidate.name}
                  value={candidate.id}
                  name="candidateSelect"
                  onChange={(e) => handleCandidateChange(e)}
                  ref={(el) => (checkRefs.current[candidate.id] = el)}
                />
                <hr />
              </div>
            ))}
          </Form.Group>

          <div className="mb-4">or:</div>
        </>
      )}
      <Form.Group controlId="votingForm.writeInCandidateInput">
        <Form.Label>Write In a Candidate:</Form.Label>
        <Form.Control type="text" ref={writeInRef} placeholder="Performer Name" onChange={(e) => handleWriteInChange(e)} />
      </Form.Group>
      <Button variant="primary" type="submit">
          Vote
      </Button>
    </Form>
  );
};

export default VotingForm;
