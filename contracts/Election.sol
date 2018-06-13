pragma solidity ^0.4.24;

contract Election 
{
	// model a candidate
	struct Candidate
	{
		uint id;
		string name;
		uint voteCount;
	}

	// store accounts that have voted
	mapping(address => bool) public voters;

	// store candidates
	mapping(uint => Candidate) public candidates;

	// store candidates count
	uint public candidatesCount;

	// voted event
	event votedEvent(uint indexed _candidateId);
	
	// constructor
	function Election() public
	{
		addCandidate("manu");
		addCandidate("bili");
	}

	// add a candidate
	function addCandidate(string _name) private
	{
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	// cast a voters
	function vote(uint _candidateId) public
	{
		// confirm if account has voted before
		require(!voters[msg.sender]);

		// require a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		// record that a voter has voted
		voters[msg.sender] = true;

		// update candidate's vote count
		candidates[_candidateId].voteCount ++;

		// trigger voted event
		votedEvent(_candidateId);
	}
}