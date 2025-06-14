import React from "react";
import Wrapper from './Wrapper';
import DataTable from './DataTable/DataTable';

const TallyDashboard = ({ data }) => {
  return (
    <Wrapper>
      <h1 className="mb-4">Candidates Results</h1>
      {data && data.length === 0 &&
      <Card className="m-2">
        <Card.Body>No performers found. Head over to the <Nav.Link inline href="/voting_booth" className="d-inline p-0">voting booth</Nav.Link> to vote for your favorite performer.</Card.Body>
      </Card>
      }
      {data && data.length > 0 && data.map((candidate) => (
        <div key={candidate.id} className="my-2">
          <div key={candidate.id}>
            <h4>{candidate.name}</h4>
            <h6>Votes: {candidate.votes.length}</h6>
            <DataTable data={candidate.votes} />
          </div>
          <hr />
        </div>
      ))}
    </Wrapper>
  );
};

export default TallyDashboard;
