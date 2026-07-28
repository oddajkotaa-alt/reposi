# Worked example: Bujairami Hectic fragrance research

User asked for non-influencer/review-community research on Bujairami Hectic, avoiding TikTok/Instagram/YouTube influencers and affiliate pages, with a concise Polish summary.

## Useful sources found

- Fragrantica page: https://www.fragrantica.com/perfume/Bujairami/Hectic-117823.html
- Parfumo page exists in search index but was blocked during this session: https://www.parfumo.com/Perfumes/bujairami/hectic
- Reddit threads existed in search results, but Reddit returned 403 for direct, old Reddit, JSON, and Jina attempts; do not cite their content unless accessible in a future run.

## Retrieval notes

Google and DuckDuckGo blocked/bot-challenged. Brave Search HTML exposed the key URLs.

Fragrantica browser navigation showed Cloudflare, but CLI retrieval worked once with curl:

```bash
curl -L --compressed -A 'Mozilla/5.0 research' \
  'https://www.fragrantica.com/perfume/Bujairami/Hectic-117823.html' \
  -o /tmp/hectic_fragrantica.html
```

The page contained HTML-escaped review metadata (`&quot;longevity&quot;`), so unescape before parsing. Filtering `(longevity=0, sillage=0)` as no-vote produced about 100 usable review metadata pairs in this session.

## Extracted facts from Fragrantica

- Launch: 2024.
- Nose: Adam Bujairami.
- Gender: unisex.
- Notes:
  - Top: citron, Calabrian bergamot, Sicilian orange.
  - Middle: Nigerian ginger, Ceylon cinnamon, Tunisian neroli.
  - Base: ambroxan, Chinese black tea, guaiac wood, olibanum.
- Stated inspiration: Louis Vuitton Imagination; described as one of the closest interpretations.
- Rating observed: 4.47/5 with 787 votes.

## Community impression synthesis

- Smell: fresh citrus-tea/ginger profile, clean/luxury soap/spa/hotel-soap vibe, ambroxan base. Some users perceive stronger citrus sparkle than LV Imagination; critical users call it citrus overload or synthetic/toilet-cleaner-like.
- Clone target: Louis Vuitton Imagination. Many Fragrantica users describe high similarity, sometimes ~90–95%, but others say the original is smoother, better blended, and more sophisticated in the tea note.
- Performance vote extraction in this session:
  - Longevity average roughly 3.46/5 after filtering no-votes; mode = 4 (`long lasting`, 7–12h per page legend).
  - Sillage average roughly 2.48/4; between moderate and strong; mode = 3 (`strong`, radiates within ~6 feet per page legend).
- Review comments were split: reports ranged from 3–5 hours with weak projection to 8–12+ hours and strong projection. Present as a range, not a single hard claim.

## Output style used

Concise Polish bullets:

- źródła sprawdzone;
- co klonuje;
- profil zapachowy;
- podobieństwo to LV Imagination;
- projekcja/sillage and longevity with disagreement;
- confidence/limitations.

Mention blocked Parfumo/Reddit as limitations, not evidence.
