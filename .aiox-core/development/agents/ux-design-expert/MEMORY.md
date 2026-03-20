# UX Design Expert Agent Memory (Uma)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Responsibilities
- Design system definition and maintenance
- Component library design
- Accessibility standards and WCAG compliance
- UX/UI specification for features
- Design review and QA

### Design System Principles
- Consistency: Unified visual language across all pages
- Accessibility: WCAG 2.1 AA minimum
- Performance: Design decisions informed by Web Vitals
- Responsiveness: Mobile-first approach

### Nuvemshop FTP Styling Constraints
**Safe to Modify:**
- Colors, fonts, spacing, shadows, gradients
- CSS transitions and animations
- Responsive breakpoints
- Custom CSS classes (no structure changes)

**LOCKED (Cannot Modify):**
- Checkout form structure (form fields, order)
- Footer attribution (must remain visible)
- Contact/Registration/Newsletter form fields
- Form submission logic

### Design System for Patagang
**Colors:**
- Primary Yellow: #EAFE67 (use sparingly, high saturation)
- Primary Black: #1A1A1A
- Gray Neutral: #F0F0F0, #E8E8E8 (recommended for UI)
- Green (success): #00CC66

**Typography:**
- Heading font: Familjen Grotesk (SemiBold, bold)
- Body font: Familjen Grotesk (Regular, medium)
- Font sizing: Scale from 12px → 24px base

**Components:**
- Button: 12px height, 8px padding, rounded corners
- Card: White background, subtle shadow, 16px padding
- Form input: Border-based (no floating label)
- Modal: Dark overlay, centered, max-width 600px

### Accessibility Guidelines
- All buttons must have aria-label or visible text
- Form labels must be associated with inputs (<label for="">)
- Color contrast: 4.5:1 for text on background
- Focus indicators: Always visible, 2px outline

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->
