# Tailscale + Mullvad Exit Node Architecture

## 1. WireGuard — The Underlying Tunnel

WireGuard is the encrypted transport layer that Tailscale is built on. Every node
(your server, your phone, the Mullvad node) holds a **key pair**:

- **Private key** — kept secret on the device, never shared
- **Public key** — shared with peers so they can encrypt traffic destined for you

```
Your server                        Mullvad node
(nixos)                            (se-mma-wg-102)
┌─────────────────┐                ┌─────────────────┐
│ private key: XYZ│                │ private key: ABC│
│ public key:  xyz│  <-- knows --> │ public key:  abc│
└─────────────────┘                └─────────────────┘
```

### Packet flow — server to internet via Mullvad

```
1. Raw packet (e.g. curl google.com)
        │
        ▼
2. Encrypted using Mullvad's public key
   (only Mullvad's private key can decrypt it)
        │
        ▼
3. Wrapped in a plain UDP packet
   destined for 45.83.220.69:51820  (Mullvad's real internet IP)
        │
        ▼
4. Travels the internet as encrypted noise
        │
        ▼
5. Mullvad decrypts with its private key
        │
        ▼
6. Forwards the original packet to the internet
```

On the wire it looks like:

```
[your home IP] --> [UDP: encrypted blob] --> [45.83.220.69]
```

No handshake, no session, no login — WireGuard just encrypts packets and sends
them. This is why it is significantly faster and simpler than older VPNs like
OpenVPN or IPSec.

### Where Tailscale fits in

WireGuard alone requires manually exchanging public keys and configuring
endpoints between every pair of peers. Tailscale automates this via its
**coordination server**:

```
Tailscale coordination server (cloud)
         │
         │  distributes public keys + endpoints for all peers
         │
    ┌────┴────┐
    │         │
 nixos      iphone
 server      phone
    │
    └──[WireGuard tunnel]──► Mullvad node ──► internet
```

The coordination server handles **key exchange and peer discovery only** —
your actual traffic never passes through it. Once keys are exchanged, all
traffic flows peer-to-peer over WireGuard directly.

### Key facts

- WireGuard runs in the **Linux kernel** — it is not userspace software
- Tailscale exposes it as the `tailscale0` virtual network interface
- Encryption uses **Curve25519** (key exchange) + **ChaCha20** (encryption) + **Poly1305** (authentication)
- Your server's WireGuard tunnel to Mullvad was confirmed active:
  ```
  direct 45.83.220.69:51820, tx 2960936 rx 47473756
  ```

---

<!-- Next sections added as we work through each bullet point -->
