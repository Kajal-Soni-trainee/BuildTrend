export const onlyChar = (value) => {
  if (value != "") {
    return /^[a-zA-Z]+$/.test(value) ? true : false;
  }
  return true;
};

export const isFirstLetterCap = (value) => {
  if (value != "") {
    return /^[A-Z]/.test(value) ? true : false;
  }
  return true;
};

export const isNumber = (value) => {
  if (value != "") {
    return /[0-9]/.test(value) ? true : false;
  }
  return true;
};

export const isCapAlpha = (value) => {
  if (value != "") {
    return /[A-Z]/.test(value) ? true : false;
  }
  return true;
};

export const isSpecialChar = (value) => {
  if (value != "") {
    return value.includes("@" || "#" || "$" || "&" || "%" || "-");
  }
  return true;
};

export const isPhone = (value) => {
  if (value != "") {
    return /^[0-9]{10}$/.test(value) ? true : false;
  }
  return true;
};
