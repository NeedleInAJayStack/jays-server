provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
variable "cloudflare_api_token" {}
variable "jaysdesktop_ip" {
  default = "97.117.0.165"
}

data "cloudflare_zone" "jayherron_org" {
  name = "jayherron.org"
}
data "cloudflare_zone" "herron_dev" {
  name = "herron.dev"
}
data "cloudflare_zone" "jayherron_dev" {
  name = "jayherron.dev"
}
data "cloudflare_zone" "jay_herron_com" {
  name = "jay-herron.com"
}

# jayherron.org

resource "cloudflare_ruleset" "jayherron_org" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "default"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  rules {
    action      = "redirect"
    description = "Redirect to herron.dev"
    enabled     = true
    expression  = "(http.request.full_uri wildcard r\"https://*.jayherron.org*\")"

    action_parameters {
      from_value {
        preserve_query_string = true
        status_code           = 301
        target_url {
          expression = "wildcard_replace(http.request.full_uri, r\"https://*.jayherron.org*\", r\"https://$${1}.herron.dev$${2}\")"
        }
      }
    }
  }
}

# A Records
resource "cloudflare_record" "a_bitwarden" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "bitwarden"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_cal" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "cal"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_data" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "data"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_grafana" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "grafana"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_home" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "home"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_jayherron_org" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "jayherron.org"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_nextcloud" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "nextcloud"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_plex" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "plex"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_recipes" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "recipes"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_superset" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "superset"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_syncthing" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "syncthing"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_trello_bot" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "trello-bot"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_utility_api" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "utility-api"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "a_www" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "www"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}

# CNAME records
resource "cloudflare_record" "cname_protonmail" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  content = "protonmail.domainkey.dd7nxyrs4dk5xdzlpo4hrsfomsmpgn6bf2i34c6lki4lzau6p4aaa.domains.proton.ch"
  proxied = false
}
resource "cloudflare_record" "cname_protonmail2" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  content = "protonmail2.domainkey.dd7nxyrs4dk5xdzlpo4hrsfomsmpgn6bf2i34c6lki4lzau6p4aaa.domains.proton.ch"
  proxied = false
}
resource "cloudflare_record" "cname_protonmail3" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  content = "protonmail3.domainkey.dd7nxyrs4dk5xdzlpo4hrsfomsmpgn6bf2i34c6lki4lzau6p4aaa.domains.proton.ch"
  proxied = false
}

# MX records
resource "cloudflare_record" "mx_mailsec_protonmail" {
  zone_id  = data.cloudflare_zone.jayherron_org.id
  name     = "jayherron.org"
  type     = "MX"
  content  = "mailsec.protonmail.ch"
  priority = 20
  proxied  = false
}
resource "cloudflare_record" "mx_mail_protonmail" {
  zone_id  = data.cloudflare_zone.jayherron_org.id
  name     = "jayherron.org"
  type     = "MX"
  content  = "mail.protonmail.ch"
  priority = 10
  proxied  = false
}

# TXT records
resource "cloudflare_record" "txt_dmarc" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=none; rua=mailto:address@yourdomain.com"
  proxied = false
}
resource "cloudflare_record" "txt_jayherron_org_spf1" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "jayherron.org"
  type    = "TXT"
  content = "v=spf1 include:_spf.protonmail.ch mx ~all"
  proxied = false
}
resource "cloudflare_record" "txt_jayherron_org_protonmail_verification" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "jayherron.org"
  type    = "TXT"
  content = "protonmail-verification=5af174d6e5925d374fa8550f6b434760510f8ff9"
  proxied = false
}
resource "cloudflare_record" "txt_protonmail_domainkey" {
  zone_id = data.cloudflare_zone.jayherron_org.id
  name    = "protonmail._domainkey"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCz+Uq5u7Hn/wPpmjoehbWsALNFWDH8pUXAC4oupv9n2N9GfJTztyflJ7Vj/mAIAVyC0+YJBwUg7jPPgfc6MZiE+jknxpJWwMf2pSDrcTge/xCNePPEDR0ub/e9H0RYVuqVF9bcfonszg5N9JyM3YaTLJxe1l+PjFUzwG9ats+MAwIDAQAB"
  proxied = false
}


# herron.dev

# A Records
resource "cloudflare_record" "herron_dev_a_root" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "herron.dev"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "herron_dev_a_wildcard" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "*"
  type    = "A"
  content = var.jaysdesktop_ip
  proxied = true
}
resource "cloudflare_record" "herron_dev_cname_protonmail" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  content = "protonmail.domainkey.dcgwlficuvageoro6lkemesa6dzrqu2ypglv3njkxaje5rsjk23pq.domains.proton.ch."
  proxied = false
}
resource "cloudflare_record" "herron_dev_cname_protonmail2" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  content = "protonmail2.domainkey.dcgwlficuvageoro6lkemesa6dzrqu2ypglv3njkxaje5rsjk23pq.domains.proton.ch."
  proxied = false
}
resource "cloudflare_record" "herron_dev_cname_protonmail3" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  content = "protonmail3.domainkey.dcgwlficuvageoro6lkemesa6dzrqu2ypglv3njkxaje5rsjk23pq.domains.proton.ch."
  proxied = false
}
resource "cloudflare_record" "herron_dev_mx_mail_protonmail" {
  zone_id  = data.cloudflare_zone.herron_dev.id
  name     = "herron.dev"
  type     = "MX"
  content  = "mail.protonmail.ch"
  priority = 10
  proxied  = false
}
resource "cloudflare_record" "herron_dev_mx_mailsec_protonmail" {
  zone_id  = data.cloudflare_zone.herron_dev.id
  name     = "herron.dev"
  type     = "MX"
  content  = "mailsec.protonmail.ch"
  priority = 20
  proxied  = false
}
resource "cloudflare_record" "herron_dev_txt_protonmail_verification" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "herron.dev"
  type    = "TXT"
  content = "protonmail-verification=1fea0a3fe95573f3dd296b09d692b8c615faea75"
  proxied = false
}
resource "cloudflare_record" "herron_dev_txt_dmarc" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=quarantine"
  proxied = false
}
resource "cloudflare_record" "herron_dev_txt_spf1" {
  zone_id = data.cloudflare_zone.herron_dev.id
  name    = "herron.dev"
  type    = "TXT"
  content = "v=spf1 include:_spf.protonmail.ch ~all"
  proxied = false
}