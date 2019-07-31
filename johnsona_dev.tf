resource "google_dns_managed_zone" "johnsona_dev" {
  name        = "johnsona-dev"
  dns_name    = "johnsona.dev."
  description = "johnsona.dev zone"
  labels = {
    managed = "true"
  }

  dnssec_config {
    kind          = "dns#managedZoneDnsSecConfig"
    non_existence = "nsec3"
    state         = "off"

    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 2048
      key_type   = "keySigning"
      kind       = "dns#dnsKeySpec"
    }
    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 1024
      key_type   = "zoneSigning"
      kind       = "dns#dnsKeySpec"
    }
  }
}
