# Monty Hall — Why host policy matters

Small Monte Carlo simulation that shows two versions of the Monty Hall game:

1) **Standard host (textbook Monty Hall)** — the host always opens a door with a goat and then offers a switch.
    In this case, the host’s behavior is informative (he avoids the car).
   → Switching wins with probability **2/3**; staying wins with **1/3**.

3) **Random host (conditioned on a goat reveal)** — the host randomly opens one of the other two doors.
    In this case, the goat reveal happened only by chance.
   → Switching and staying both win with probability **1/2**.

**How we obtained the information** (host policy) determines the correct inference.

![preview](docs/preview.png)

## Quick start
Just run `monty_hall_demo`.

The script plots the running (cumulative) success rates.
