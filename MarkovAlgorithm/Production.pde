class Production
{
  String pattern ,replacemnt;
  boolean isTerminating = false;
  Production(String patt ,String replace)
  {
    pattern = patt;
    replacemnt = replace;
  }
   Production(String patt ,String replace, boolean isTermn)
  {
    pattern = patt;
    replacemnt = replace;
    isTerminating = isTermn;
  }
}