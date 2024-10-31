# PetWatcher

*Original Tagline*: **Connecting pet sitters with pet owners**

## Problem Statement (Original)
Leverage Fido Tabby to connect pet owners with people can watch pets in their local area

## Target Audience (Original)
- Pet owners
- Pet sitters

## Features

- [X] Find sitter by proximity
- [X] Dual profile (Sitter and Owner at the same time)
- [X] Rating system (stars and comments)
- [X] Owner/Pet/Sitter picture
- [X] Pet details
- [X] Accept match service in-app (Match before providing phone)
- [X] Decent front-end work
- [ ] Filter by breed
- [ ] ~~Schedule system~~

## Steps

- Authentication / Registration
- Geolocation methods (proximity) - Sávio
- Pages
  - Pet CRUD - Franco
  - Review CRUD - Nehama

## Technical details

- Authentication: Devise (out of box)
- CSS: Bootstrap
- Database: Standard SQLite (out of box rails default)

## Entity Diagram

```mermaid
---
title: PetWatcher ER
---
erDiagram
  PERSON ||--|| LOCATION : uses
  SITTER_PROFILE }|--o{ SPECIE : accepts
  PERSON |o--|| SITTER_PROFILE : has
  PERSON }|--|| PET : have
  PET ||--o{ SPECIE : has
  PET ||--o{ REVIEW : have
  PERSON ||--o{ REVIEW : have
  PERSON ||--o| REVIEW : does

  SITTER_PROFILE{
    bigint id
    decimal rate
  }
  PERSON {
    bigint id
    string name
    string email
    string phone
    bool sitter
  }
  PET {
    bigint id
    string name
  }
  SPECIE {
    bigint id
    string name
  }
  LOCATION {
    bigint id
    decimal latitude
    decimal longitude
  }
  REVIEW {
    bigint id
    int stars
    string comment
    string type
  }
```