import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Validator {
  static FormFieldValidator<T> list<T>(List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> required<T>() {
    return FormBuilderValidators.required(errorText: 'Bagian ini tidak boleh kosong');
  }

  static FormFieldValidator<String> email<T>() {
    return FormBuilderValidators.email(errorText: 'Masukkan dengan email valid');
  }

  static FormFieldValidator<String> minLength<T>(int minLength) {
    return FormBuilderValidators.minLength(minLength);
  }

  static FormFieldValidator<String> password<T>() {
    return FormBuilderValidators.minLength(8, errorText: 'Password minimal 8 karakter');
  }

  static FormFieldValidator<String> year<T>() {
    return FormBuilderValidators.equalLength(4, errorText: 'Masukkan dengan tahun valid');
  }

  static FormFieldValidator<String> min<T>(int min) {
    return FormBuilderValidators.min(min, errorText: 'Nilai harus lebih dari atau sama dengan $min');
  }

  static FormFieldValidator<String> max<T>(int max) {
    return FormBuilderValidators.max(max, errorText: 'Nilai harus kurang dari atau sama dengan $max');
  }

  static FormFieldValidator<String> maxLength<T>(int maxLength) {
    return FormBuilderValidators.maxLength(maxLength);
  }

  static FormFieldValidator<String> numeric<T>() {
    return FormBuilderValidators.numeric(errorText: 'Bagian ini harus diisi dengan angka');
  }

  static FormFieldValidator<String> npwp<T>(int minLength) {
    return FormBuilderValidators.minLength(minLength, errorText: 'NPWP harus diisi dengan 15 karakter');
  }
}