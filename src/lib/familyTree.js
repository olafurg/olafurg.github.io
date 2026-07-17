// Build-time layout for the family tree page (src/pages/family.astro).
//
// Two base people sit at the trunk (generation 0). Ancestors ("roots") are
// laid out below the trunk with a halving binary fan (classic pedigree
// layout — guarantees siblings' subtrees never overlap). Descendants
// ("branches") are laid out above the trunk with a standard bottom-up tidy
// tree (subtree width = sum of children's widths).

const GEN_HEIGHT = 110;
const COUPLE_GAP = 130;
const ROOT_INITIAL_HALF = 190;
const ROOT_MIN_HALF = 20;
const LEAF_WIDTH = 130;
const SPOUSE_OFFSET = 30;

function personLabel(person) {
  if (person.displayName) return person.displayName;
  if (!person.died) return person.firstName;
  return person.lastName ? `${person.firstName} ${person.lastName}` : person.firstName;
}

function personYears(person) {
  if (!person.born && !person.died) return '';
  if (person.died) return `${person.born ?? '?'}–${person.died}`;
  return `${person.born}`;
}

export function buildFamilyTree({ baseIds, people }) {
  const byId = new Map(people.map((p) => [p.id, p]));
  const childrenOf = new Map();
  for (const p of people) {
    for (const parentId of p.parents || []) {
      if (!childrenOf.has(parentId)) childrenOf.set(parentId, []);
      childrenOf.get(parentId).push(p.id);
    }
  }

  const nodes = new Map();
  const edges = [];
  const [baseA, baseB] = baseIds;

  const addNode = (id, x, y, generation) => {
    const person = byId.get(id);
    if (!person) return;
    nodes.set(id, {
      id,
      x,
      y,
      generation,
      kind: generation === 0 ? 'base' : generation > 0 ? 'ancestor' : 'descendant',
      label: personLabel(person),
      years: personYears(person),
      note: person.note || '',
    });
  };

  // --- trunk: the base couple ---
  addNode(baseA, -COUPLE_GAP, 0, 0);
  if (baseB && byId.has(baseB)) {
    addNode(baseB, COUPLE_GAP, 0, 0);
    edges.push({
      id: `spouse-${baseA}-${baseB}`,
      x1: -COUPLE_GAP, y1: 0, x2: COUPLE_GAP, y2: 0,
      kind: 'spouse', generation: 0,
    });
  }

  // --- roots: ancestors, halving binary fan ---
  function layoutAncestors(personId, xCenter, halfWidth, generation) {
    const person = byId.get(personId);
    const parents = (person && person.parents) || [];
    const childHalf = Math.max(halfWidth / 2, ROOT_MIN_HALF);
    const slots = [xCenter - childHalf, xCenter + childHalf];
    parents.slice(0, 2).forEach((parentId, i) => {
      if (!parentId || !byId.has(parentId)) return;
      const x = slots[i];
      const y = generation * GEN_HEIGHT;
      addNode(parentId, x, y, generation);
      const child = nodes.get(personId);
      edges.push({
        id: `root-${parentId}-${personId}`,
        x1: x, y1: y, x2: child.x, y2: child.y,
        kind: 'root', generation,
      });
      layoutAncestors(parentId, x, childHalf, generation + 1);
    });
  }
  if (byId.has(baseA)) layoutAncestors(baseA, -COUPLE_GAP, ROOT_INITIAL_HALF, 1);
  if (baseB && byId.has(baseB)) layoutAncestors(baseB, COUPLE_GAP, ROOT_INITIAL_HALF, 1);

  // --- branches: descendants, bottom-up tidy tree ---
  const widthCache = new Map();
  function subtreeWidth(personId) {
    if (widthCache.has(personId)) return widthCache.get(personId);
    const kids = childrenOf.get(personId) || [];
    const width = kids.length === 0
      ? LEAF_WIDTH
      : Math.max(kids.reduce((sum, kidId) => sum + subtreeWidth(kidId), 0), LEAF_WIDTH);
    widthCache.set(personId, width);
    return width;
  }

  function layoutDescendants(personId, xLeft, generation) {
    const kids = childrenOf.get(personId) || [];
    const y = -generation * GEN_HEIGHT;
    let x;
    const childPositions = [];

    if (kids.length === 0) {
      x = xLeft + LEAF_WIDTH / 2;
    } else {
      let cursor = xLeft;
      for (const kidId of kids) {
        const w = subtreeWidth(kidId);
        const kidX = layoutDescendants(kidId, cursor, generation + 1);
        childPositions.push(kidId);
        cursor += w;
      }
      const firstX = nodes.get(childPositions[0]).x;
      const lastX = nodes.get(childPositions[childPositions.length - 1]).x;
      x = (firstX + lastX) / 2;
    }

    addNode(personId, x, y, -generation);

    const person = byId.get(personId);
    (person.spouseIds || []).forEach((spouseId, i) => {
      if (nodes.has(spouseId) || !byId.has(spouseId)) return;
      const sx = x + SPOUSE_OFFSET * (i + 1);
      addNode(spouseId, sx, y, -generation);
      edges.push({
        id: `spouse-${personId}-${spouseId}`,
        x1: x, y1: y, x2: sx, y2: y,
        kind: 'spouse', generation: -generation,
      });
    });

    for (const kidId of childPositions) {
      const kidNode = nodes.get(kidId);
      edges.push({
        id: `branch-${personId}-${kidId}`,
        x1: x, y1: y, x2: kidNode.x, y2: kidNode.y,
        kind: 'branch', generation: kidNode.generation,
      });
    }

    return x;
  }

  const rootChildren = [];
  const seenChild = new Set();
  for (const pid of [baseA, baseB]) {
    if (!pid) continue;
    for (const kidId of childrenOf.get(pid) || []) {
      if (!seenChild.has(kidId)) {
        seenChild.add(kidId);
        rootChildren.push(kidId);
      }
    }
  }

  if (rootChildren.length > 0) {
    const totalWidth = rootChildren.reduce((sum, id) => sum + subtreeWidth(id), 0);
    let cursor = -totalWidth / 2;
    const positioned = [];
    for (const kidId of rootChildren) {
      const w = subtreeWidth(kidId);
      layoutDescendants(kidId, cursor, 1);
      positioned.push(kidId);
      cursor += w;
    }
    for (const kidId of positioned) {
      const kidNode = nodes.get(kidId);
      edges.push({
        id: `branch-base-${kidId}`,
        x1: 0, y1: 0, x2: kidNode.x, y2: kidNode.y,
        kind: 'branch', generation: kidNode.generation,
      });
    }
  }

  const nodeList = [...nodes.values()];
  const xs = nodeList.map((n) => n.x);
  const ys = nodeList.map((n) => n.y);
  const bounds = {
    minX: Math.min(...xs, 0),
    maxX: Math.max(...xs, 0),
    minY: Math.min(...ys, 0),
    maxY: Math.max(...ys, 0),
  };

  return { nodes: nodeList, edges, bounds };
}
