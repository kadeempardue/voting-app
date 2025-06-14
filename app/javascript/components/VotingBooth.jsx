import React from "react";
import Wrapper from './Wrapper';
import VotingForm from './VotingForm/VotingForm';

const VotingBooth = ({ candidates }) => {
  return (
    <Wrapper>
      <h1>Voting Booth</h1>
      <VotingForm candidates={candidates} />
    </Wrapper>
  );
};

export default VotingBooth;
