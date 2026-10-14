final studentEmailPattern = RegExp(
  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.edu\.in$',
);

String normalizeStudentEmail(String value) => value.trim().toLowerCase();

bool isValidStudentEmail(String value) =>
    studentEmailPattern.hasMatch(normalizeStudentEmail(value));
