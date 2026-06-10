# Touchpad

This setup uses a custom Niri touchpad configuration to keep two-finger scrolling comfortable while fixing three-finger gesture direction.

## Configuration

Current touchpad block:

```kdl
touchpad {
    tap
    scroll-factor 0.5 horizontal=-0.4 vertical=-0.4
    natural-scroll
}
```

## Behavior

Expected behavior:

- Two-finger scrolling feels natural.
- Three-finger horizontal gestures move in the desired direction.
- Three-finger vertical gestures move in the desired direction.
- Tap-to-click is enabled.

## Why this configuration

Using only `natural-scroll` changed the direction of regular scrolling and gestures together.

Using `natural-scroll` together with negative horizontal and vertical scroll factors produced the best behavior for this setup:

```kdl
scroll-factor 0.5 horizontal=-0.4 vertical=-0.4
```

## Notes

This behavior may be hardware-dependent and may need adjustment on other touchpads.

If gestures feel too fast or too slow, adjust the values:

```kdl
scroll-factor 0.5 horizontal=-0.4 vertical=-0.4
```

For example:

```kdl
scroll-factor 0.5 horizontal=-0.3 vertical=-0.3
```

or:

```kdl
scroll-factor 0.5 horizontal=-0.5 vertical=-0.5
```
