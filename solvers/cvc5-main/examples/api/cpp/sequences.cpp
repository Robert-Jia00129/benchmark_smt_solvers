/******************************************************************************
 * Top contributors (to current version):
 *   Andres Noetzli, Mathias Preiner, Aina Niemetz
 *
 * This file is part of the cvc5 project.
 *
 * Copyright (c) 2009-2022 by the authors listed in the file AUTHORS
 * in the top-level source directory and their institutional affiliations.
 * All rights reserved.  See the file COPYING in the top-level source
 * directory for licensing information.
 * ****************************************************************************
 *
 * A simple demonstration of reasoning about sequences with cvc5 via C++ API.
 */

#include <cvc5/cvc5.h>

#include <iostream>

using namespace cvc5;

int main()
{
  Solver slv;

  // Set the logic
  slv.setLogic("QF_SLIA");
  // Produce models
  slv.setOption("produce-models", "true");
  // The option strings-exp is needed
  slv.setOption("strings-exp", "true");
  // Set output language to SMTLIB2
  slv.setOption("output-language", "smt2");

  // Sequence sort
  Sort intSeq = slv.mkSequenceSort(slv.getIntegerSort());

  // Sequence variables
  Term x = slv.mkConst(intSeq, "x");
  Term y = slv.mkConst(intSeq, "y");

  // Empty sequence
  Term empty = slv.mkEmptySequence(slv.getIntegerSort());
  // Sequence concatenation: x.y.empty
  Term concat = slv.mkTerm(Kind::SEQ_CONCAT, {x, y, empty});
  // Sequence length: |x.y.empty|
  Term concat_len = slv.mkTerm(Kind::SEQ_LENGTH, {concat});
  // |x.y.empty| > 1
  Term formula1 = slv.mkTerm(Kind::GT, {concat_len, slv.mkInteger(1)});
  // Sequence unit: seq(1)
  Term unit = slv.mkTerm(Kind::SEQ_UNIT, {slv.mkInteger(1)});
  // x = seq(1)
  Term formula2 = slv.mkTerm(Kind::EQUAL, {x, unit});

  // Make a query
  Term q = slv.mkTerm(Kind::AND, {formula1, formula2});

  // check sat
  Result result = slv.checkSatAssuming(q);
  std::cout << "cvc5 reports: " << q << " is " << result << "." << std::endl;

  if (result.isSat())
  {
    std::cout << "  x = " << slv.getValue(x) << std::endl;
    std::cout << "  y = " << slv.getValue(y) << std::endl;
  }
}
