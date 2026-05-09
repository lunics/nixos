{
  flake.aspects._emails.homeManager = { lib }:
  {
    obfuscate = email: lib.strings.concatStrings (
      lib.reverseList (lib.strings.stringToCharacters email)
    );
  };
}
