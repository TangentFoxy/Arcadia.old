# Vessels

Everything is a vessel. Vessels can contain other vessels (child vessels), in
which case they are that vessel's parent. Vessels in the same parent vessel are
sibling vessels.

Vessels can be their own parent or child. They can be unowned, or owned by any
number of vessels - including themselves.

Vessels have a name, an optional attribute, and a unique id. A `red fox` is a
vessel named `fox` with the attribute `red`. `library#0` or `#0` refer to the
starting parent vessel - initially an unattributed library.

## Special Names

The following vessel names have special meaning, and will refer to this special
meaning unless an id is used:

- `self`: The current vessel.
- `parent`: The current vessel's parent.
- `vessel`: Any sibling vessel.
- `vessels`: All sibling vessels.

# Actions

Vessels interact with the world through actions. You are possessing a vessel.
When you interact with the world, you are doing so as that vessel.

Everywhere vessel appears in action syntax, you can use any combination of name,
attribute, and id. When your action is not specific, it can be applied to
multiple vessels. Be careful!

When actions refer to multiple vessels, the first vessel is the specified
vessel, and the second vessel is the target vessel.

## Creation

- Create [a/an/the] vessel
  Create a new vessel in your parent vessel.
- Clone [a/an/the/any] vessel [in] [vessel] | [as] [vessel]
  Clone a sibling vessel.
- Note|Describe
  Add a note/description to the parent vessel.
- Transform|Transmute into/vessel [in/into] [a/any/an/the] [attrib] vessel
  first into transforms self, or select a vessel to transform
- Program|Trigger
  (remember programs are run as if the triggering vessel executed the actions
  themselves, trigger can set the default trigger and specific actions, now I
  get it!)
  `trigger passive hello Displays hello in the UI when carried.
  cast the storm scroll at the golden beetle Trigger a distant vessel's automation as another vessel.`
- Usage

## Permission

Vessels default to being owned by the vessel that created them, and all its
owners. Permissions default to the parent vessel's permissions at time of
creation.

Everyone refers to all vessels that do not own a vessel.

- Give [a/an/the/any] vessel to [a/an/the/any] vessel
  Adds target vessel to the owners of specified vessel.
- Allow [permission] on/of/in [a/an/the/any] vessel
  Grants a permission to everyone on specified vessel.
- Deny
  Removes a permission from everyone on specified vessel.
- Disown [a/an/the/any] vessel [of vessel]
  Remove yourself or a target vessel from owners of specified vessel. Can also
  "disown vessel of all"
- Inspect [a/an/the/any] vessel
  Displays the vessel's id

## Interaction

- Look [at (a/an/the/any)] [vessel]
  List vessels in parent vessel, or describe specified vessel.
- Use|Cast [a/an/the/any] vessel/action [at (a/an/the/any)] [vessel]

- Echo
  Print text at your vessel only.
- Speak
  Print text at all vessels in parent vessel.
- Learn|Help [to/about] [vessel/action]
  List vessels in Help vessel, describe specified child vessel of Help
  vessel, or describe custom action of sibling vessel.

## Movement

- Enter [a/an/the/any] vessel
  Enter a sibling vessel.
- Leave|Exit
  Leave your parent vessel, by entering its parent vessel.
- Move [a/an/the/any] vessel in/into/to [a/an/the/any] vessel
  Move a sibling vessel into a sibling target vessel.
- Warp [a/an/the/any] [vessel] in/into/to [a/an/the/any] vessel/anywhere
  Move yourself or a sibling vessel into or to the parent of a target vessel, or
  to a random vessel.

## Self

- Become [a/an/the/any] vessel
  Possess specific vessel.
- Take [a/an/the/any] vessel
  Move a sibling vessel into yourself. Can also "take anyting" to take a random
  sibling vessel.
- Drop [a/an/the/any] vessel
  Move a child vessel from yourself into your parent vessel. Can also
  "drop anything" to drop a random child vessel.
- Inventory
  List your child vessels.

## Other Actions

Programmed vessels can make other actions available. Trigger is used to program
these actions. Programmed vessels without a custom action are activated by Use.

## "all"

Some actions allow "all [attribute/name] [vessels]" in place of
"[a/an/the/any] vessel" to act on all sibling vessels or all sibling vessels
with the same attribute.

## IDs

Every vessel has a unique id. This allows you to specify a vessel even if it
appears identical to another vessel. Use Inspect to view a vessel's id.

## Permissions List

Vessels default to being owned by the vessel that created them, and all its
owners. Permissions default to the parent vessel's permissions at time of
creation.

Permissions apply to everyone that does not own a vessel. Owners have all
permissions at all times.

- use: Use|Cast, custom actions
- look: Look in/at, Learn|Help custom actions
- enter: Enter, Warp yourself (deny overrides children, allow does nothing to
  children)
  - create: Create, Clone inside
  - modify: (deny overrides children, allow does nothing to children)
    - note: Note|Describe it
    - transform: Transform|Transmute it
    - program: Program|Trigger, Usage it
  - move-within: Move, Warp vessels, Take, Drop
  - speak: Speak
- move: Move, Take

#### Notes to self

- become a -> siblings, become the -> specific
- note: visibility == sibling
- multiple actions can be done at once using & symbol
  - in order to keep this from breaking more complex programs, I should make it
    possible to group things in quotes? or just skip this feature
  - need to be able to parse quote blocks.. (so lua can contain the & symbol)
  - nope.. just ignore double &&'s ?
- in/into & to mean different things to Warp, but not to Move
- look permission only applies to its description (sibling vessels are always
  listed by look)
- Add default permissions, and explain them
- explain that Give can be used on unowned vessels
- Take on an unowned vessel DOES NOT give ownership. This way public vessels can
  be traded.
- ability to use parent and self as vessels, referring to yourself and the
  current parent (if anything is named parent or self, you must select it with
  its id)
- document ids as ids (in fact, they will be called that in dB anyhow..)
- Programming
  - first order programming is with actions
  - second order, you can program more complex actions in Lua, in a sandbox env
    that can be passed args from usage
  - Lua access: self, parent, siblings (these can be walked to get to others),
    vessel(id), act() can execute actions on behalf of self
  - all Lua access passes through checks to make sure it has permission to be
    accessed
- Inspect action ?
