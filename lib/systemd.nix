lib: {
  mkGraphicalService = lib.recursiveUpdate {
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
  };
}
