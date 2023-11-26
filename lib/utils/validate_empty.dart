String? validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'فیلد نمیتونه خالی باشه!';
  }

  return null;
}
