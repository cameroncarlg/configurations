# Architecture Docs — To Do

## Tailscale + Mullvad Exit Node

- [x] WireGuard is the underlying tunnel
- [ ] The Mullvad node is just another Tailscale peer
- [ ] Policy routing decides what goes where
- [ ] Not all traffic goes through Mullvad
- [ ] LAN traffic is explicitly excluded
- [ ] Mullvad receives the traffic and forwards it to the internet
