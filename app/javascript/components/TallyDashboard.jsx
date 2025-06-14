import React from "react";
import Wrapper from './Wrapper';
import DataTable from './DataTable/DataTable';
import { Card, Nav } from 'react-bootstrap';

const TallyDashboard = ({ data }) => {
  return (
    <Wrapper>
      <h1 className="mb-4">Voting Results</h1>
      {data && data.length === 0 &&
      <Card className="m-2">
        <Card.Body>No candidates found. Head over to the <Nav.Link href="/voting_booth" className="d-inline p-0">voting booth</Nav.Link> to vote for your favorite performer.</Card.Body>
      </Card>
      }
      {data && data.length > 0 && data.map((candidate) => (
        <div key={candidate.id} className="my-2">
          <div key={candidate.id}>
            <h4>{candidate.name}</h4>
            <h6>Votes: {candidate.votes.length}</h6>
            {process.env.NODE_ENV === 'development' && (
              <div className="pt-2">
                <b className="text-danger">Development Only:</b>
                <DataTable data={candidate.votes} />
              </div>
            )}
          </div>
          <hr />
        </div>
      ))}
    </Wrapper>
  );
};

export default TallyDashboard;
