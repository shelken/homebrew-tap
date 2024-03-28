prefetch-url url:
  @nix-prefetch-url --print-path '{{ url }}' | awk 'NR>1{print $1}' | xargs shasum -a 256
