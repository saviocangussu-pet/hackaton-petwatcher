# PetWatcher

*Original Tagline*: **Connecting pet sitters with pet owners**

## Problem Statement (Original)
Leverage Fido Tabby to connect pet owners with people can watch pets in their local area

## Target Audience (Original)
- Pet owners
- Pet sitters

## Features

- [ ] Find sitter by proximity
- [ ] Filter by breed
- [ ] Owner/Pet/Sitter picture
- [ ] Accept match service in-app (Match before providing phone     )
- [ ] Schedule system
- [ ] Rating system (stars and comments)
- [ ] Pet details

## Entity Diagram

```mermaid
---
title: PetWatcher ER
---
erDiagram
  OWNER }|--|| PET : have
  OWNER ||--|| LOCATION : uses
  SITTER ||--|| LOCATION : uses
  SITTER }|--o{ SPECIE : accepts
  PET ||--o{ SPECIE : has

  OWNER {
    bigint id
    string name
    string phone
  }
  SITTER {
    bigint id
    string name
    string phone
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
```