class Data {
  static String mostraData(data) {
    if (data == null){
      data = DateTime.now();
    }
    return (((data.day<10) ? ('0' + data.day.toString()) : (data.day.toString())) + '/' +
        ((data.month<10) ? ('0' + data.month.toString()) : (data.month.toString()))
        + '/' + DateTime.now().year.toString());
  }
}