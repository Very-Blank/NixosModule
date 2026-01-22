{inputs, ...}: {
  imports = [
    inputs.colors.nixosModules.default
    ./icons
    ./swaybg
    ./theming
  ];
}
