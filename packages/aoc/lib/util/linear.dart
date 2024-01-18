// Solves a set of linear equations.
//
// `augmentedMatrix` is an augmented matrix of coeffiecients and
// constants for a given set of linear equations.
//
// Returns a list of the values for each variable that satisfies the
// equations, or an empty list if there is no solution.
//
// For example if the equations are of the form:
//
//   a1 * x + b1 * y + c1 * z = d1
//   a2 * x + b2 * y + c2 * z = d2
//   a3 * x + b3 * y + c3 * z = d3
//
// Then the augmented matrix would be:
//
// [[a1, b1, c1, d1],
//  [a2, b2, c2, d2],
//  [a3, b3, c3, d3]]
//
// The `augmentedMatrix` will be modified in place as part of the solution.
List<num> solveLinearSystem(List<List<num>> augmentedMatrix) {
  assert(augmentedMatrix.length == augmentedMatrix[0].length - 1,
      'The augmented matrix has the wrong shape.');

  if (_gaussianElimination(augmentedMatrix)) {
    return _backSubstitute(augmentedMatrix);
  }
  return [];
}

bool _gaussianElimination(List<List<num>> m) {
  final int numVariables = m.length;

  for (int i = 0; i < numVariables; i++) {
    // Partial pivoting
    for (int p = i + 1; p < numVariables; p++) {
      if (m[i][i].abs() < m[p][i].abs()) {
        // Swap rows
        final tmp = m[p];
        m[p] = m[i];
        m[i] = tmp;
      }
    }

    final denom = m[i][i];
    if (denom == 0) {
      return false;
    }

    for (int j = i + 1; j < numVariables; j++) {
      final scaling = m[j][i] / denom;
      for (int k = 0; k < numVariables + 1; k++) {
        m[j][k] -= scaling * m[i][k];
      }
    }
  }
  return true;
}

List<num> _backSubstitute(List<List<num>> m) {
  final int nVars = m.length;
  final int last = nVars - 1;
  final vars = List<num>.filled(nVars, 0);
  vars[last] = m[last][nVars] / m[last][last];

  for (int k = nVars - 2; k >= 0; k--) {
    vars[k] = m[k][nVars];
    for (int j = k + 1; j < nVars; j++) {
      vars[k] -= m[k][j] * vars[j];
    }
    vars[k] /= m[k][k];
  }
  return vars;
}
