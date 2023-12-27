class Helper {
  static response(data) {
    return {
      'statusCode': data['statusCode'],
      'message': data['message'],
      'data': data['data'],
      'attachedData': data['attachedData'],
      'error': (data['statusCode'] != 200)
    };
  }
}
