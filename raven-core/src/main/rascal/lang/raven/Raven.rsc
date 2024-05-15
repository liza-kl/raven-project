module lang::raven::Raven

// Recall this to the
data Raven
  = rvnTab(str text, list[Raven] nodes)
  | rvnButton(str text, str callback)
  | rvnTextField(str text, str callback)
  | rvnLabel(str text)
  | rvnHorizontalSpace(int space)
  | rvnVerticalSpace(int space)
  | rvnHorizontal(list[Raven])
  | rvnVertical(list[Raven])
  | rvnOptionButton(list[str] options)
  ;
