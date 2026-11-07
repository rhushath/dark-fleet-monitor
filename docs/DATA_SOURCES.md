# Data sources and terms register (reviewed 2026-11-07)

**Do not redistribute downloaded datasets from this repository without rechecking source terms.** Record exact snapshots and attribution before download.

| Source | Official URL | Access / license finding | Phase / unresolved action |
|---|---|---|---|
| Danish historical AIS | https://www.dma.dk/safety-at-sea/navigational-information/ais-data | Free historical monthly ZIP/CSV; coast-receiver observations. Download access confirmed; explicit redistribution license not verified. | 1; confirm reuse/redistribution of archive |
| AISStream | https://aisstream.io/documentation/ | Free real-time WSS with account/API key; no durable replay or SLA; license for downstream redistribution not verified. | Future; inspect accepted service terms |
| Global Fishing Watch | https://globalfishingwatch.org/our-apis/documentation/docs/license-rate-limits | API noncommercial CC BY-NC 4.0 with attribution; published 50k/day and 1.5m/month request caps. Gap/loitering for all vessel types; encounter categories do not explicitly include tanker-tanker. | Optional; request token and validate geographic coverage |
| OFAC SDN | https://ofac.treasury.gov/sanctions-list-service | Official downloadable lists include vessels; verify source schema and refresh date at ingestion. | 4 |
| EU consolidated financial sanctions | https://finance.ec.europa.eu/eu-and-world/sanctions-restrictive-measures/overview-sanctions-and-related-resources_en | Official consolidated financial sanctions available; exact format/access and reuse conditions must be checked before ingestion. | 4 |
| UK Sanctions List | https://www.gov.uk/government/publications/the-uk-sanctions-list | Official downloadable list; former OFSI consolidated list ceased updates 2026-01-28. | 4 |
| OpenSanctions | https://www.opensanctions.org/docs/commercial/exemption/ | Bulk CC BY-NC 4.0 for noncommercial use; free hosted API keys require grant. | 4 optional |
| Sentinel-1 CDSE | https://dataspace.copernicus.eu/terms-and-conditions | Sentinel data free/full/open governed by Sentinel data legal notice; portal *other content* has different terms. | 7; register account; attribute scene and source |
| World Port Index (NGA) | https://msi.nga.mil/Publications | Official publication/database discoverable; detailed redistribution format/license not checked. | 3; inspect before using |
| Marine Regions EEZ | https://www.marineregions.org/ | Potential reference geography; license not verified. | Future; confirm dataset-specific license |
| Ownership | Manually cited public documents | No automatic scraping of prohibited registries. | 4; retain source and effective date |

This is a research access inventory, not legal advice. Download availability ≠ unrestricted redistribution rights.
