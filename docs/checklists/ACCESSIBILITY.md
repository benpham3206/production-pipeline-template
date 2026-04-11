# Accessibility Checklist (WCAG 2.1 AA)

*Required for all user-facing web and mobile applications.*

## Perceivable
- [ ] All images have alt text
- [ ] Color is not the only indicator
- [ ] Text contrast ≥ 4.5:1 (normal), ≥ 3:1 (large)
- [ ] Content accessible at 200% zoom
- [ ] Captions for video, transcripts for audio

## Operable
- [ ] All interactive elements keyboard-accessible
- [ ] No keyboard traps
- [ ] Skip navigation link
- [ ] Visible focus indicators
- [ ] Sufficient time for timed interactions

## Understandable
- [ ] Language declared (`lang` attribute)
- [ ] Form inputs have visible labels
- [ ] Error messages are clear and actionable
- [ ] Consistent navigation across pages

## Robust
- [ ] Valid HTML
- [ ] Works with screen readers (test with VoiceOver + NVDA)
- [ ] Custom components have ARIA roles
- [ ] Tested with browser accessibility audit (Lighthouse)

## Testing
- [ ] Automated scan (axe-core, Lighthouse)
- [ ] Manual keyboard navigation test
- [ ] Screen reader walkthrough
- [ ] Color contrast verification
