{
  television,
  ...
}:
television.overrideAttrs (prev: {
  patches = (prev.patches or [ ]) ++ [ ./001-no-useless-cable.patch ];
})
