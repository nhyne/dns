resource "google_dns_managed_zone" "nhyne_dev" {
  name        = "nhyne-dev"
  dns_name    = "nhyne.dev."
  description = "nhyne.dev zone"
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

  timeouts {}
}

resource "google_dns_record_set" "_dmarc_txt" {
  name = "_dmarc.nhyne.dev."
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = ["v=DMARC1; p=none; rua=mailto:nhyne@nhyne.dev"]

}

resource "google_dns_record_set" "root_txt" {
  name = "nhyne.dev."
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "protonmail-verification=e6f2ef1b193c3e6429975d978dff118121e2b084",
    "v=spf1 include:_spf.protonmail.ch mx ~all"
  ]

}

resource "google_dns_record_set" "at_sign_mx" {
  name = "@.nhyne.dev."
  type = "MX"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch."
  ]

}

resource "google_dns_record_set" "at_sign_txt" {
  name = "@.nhyne.dev."
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "protonmail-verification=e6f2ef1b193c3e6429975d978dff118121e2b084",
    "v=spf1 include:_spf.protonmail.ch mx ~all"
  ]

}

resource "google_dns_record_set" "protonmail_domainkey_txt" {
  name = "protonmail._domainkey.nhyne.dev."
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0jE/Yz6A+G5QTf26iwEAFfZjUAiW3MMbBs4BQHCrnvQeizNc1pvc7HbOAKCOBWhmAvHRQTUZ0sqYGut1YFV7NhucKqywqKS4Nzz+PqONM7QbJwNgLgSxCW/AO66NL4ZzW9l2mKebkelmrtvP7k5zb78uWaPU2OeJ7J06OfwbjbQIDAQAB"
  ]

}

resource "google_dns_record_set" "lets_encrypt_validation" {
  name = "_acme-challenge.nhyne.dev."
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "SG9FjMNr4YoYc5MKSN3E5a6aL83dfmjBVuHo5xqzpKw"
  ]
}

resource "google_dns_record_set" "pi_hole" {
  name = "pi-hole.nhyne.dev."
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.nhyne_dev.name

  rrdatas = [
    "192.168.86.204"
  ]
}
