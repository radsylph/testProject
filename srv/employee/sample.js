const evaluateEmail = (email) => {
  const emailRegex =
    /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zAZ0-9-]+)*$/;
  return emailRegex.test(email);
};

console.log(evaluateEmail("asd@gmail.com"));
