import 'package:election/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contractAddress1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'election'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callfunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: null,
      fetchChainIdFromNetworkId: true);

  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callfunction('startElection', [name], ethClient, owner_private_key);
  print("Election started successfully");
  return response;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response =
      await callfunction('addCandidate', [name], ethClient, owner_private_key);
  print("Candidate added successfully");
  return response;
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  var response = await callfunction('authorizeVoter',
      [EthereumAddress.fromHex(address)], ethClient, owner_private_key);
  print("Voter authorized");
  return response;
}

Future<List> getCandidatesNum(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], ethClient);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcname, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateindex, Web3Client ethClient) async {
  var response = await callfunction(
      'vote', [BigInt.from(candidateindex)], ethClient, voter_private_key);
  print("Vote has been given successfully");
  return response;
}

Future<List> candidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('candidateInfo', [BigInt.from(index)], ethClient);
  return result;
}
