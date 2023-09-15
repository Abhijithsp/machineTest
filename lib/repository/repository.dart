



import '../network/network_service.dart';


class Repository {
  final NetworkService networkService;

  Repository(this.networkService);



  Future<dynamic> getMockApi() async {
    return networkService.getData();
  }


}
