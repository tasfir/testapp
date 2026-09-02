// Bootstrap dropdowns default to absolute positioning, which gets clipped by any
// scrollable ancestor (e.g. the `.table-responsive` wrapper around every index
// table's "Actions" dropdown). Using the "fixed" Popper strategy positions the
// menu relative to the viewport instead, so it never gets clipped or forces the
// table wrapper to grow its own scrollbars.
//
// This patches every dropdown's config right as it's about to open, via
// Bootstrap's own "show.bs.dropdown" event, rather than pre-initializing
// instances ourselves — that way it works regardless of whether Bootstrap
// lazily created the instance on first click or Turbo page-load timing.
document.addEventListener("show.bs.dropdown", (event) => {
  const instance = bootstrap.Dropdown.getInstance(event.target);
  if (!instance || instance._config.popperConfig) return;

  instance._config.popperConfig = (defaultConfig) => ({ ...defaultConfig, strategy: "fixed" });
});
