//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "RoadrunnerTestApp.h"
#include "RoadrunnerApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
RoadrunnerTestApp::validParams()
{
  InputParameters params = RoadrunnerApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

RoadrunnerTestApp::RoadrunnerTestApp(InputParameters parameters) : MooseApp(parameters)
{
  RoadrunnerTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

RoadrunnerTestApp::~RoadrunnerTestApp() {}

void
RoadrunnerTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  RoadrunnerApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"RoadrunnerTestApp"});
    Registry::registerActionsTo(af, {"RoadrunnerTestApp"});
  }
}

void
RoadrunnerTestApp::registerApps()
{
  registerApp(RoadrunnerApp);
  registerApp(RoadrunnerTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
RoadrunnerTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  RoadrunnerTestApp::registerAll(f, af, s);
}
extern "C" void
RoadrunnerTestApp__registerApps()
{
  RoadrunnerTestApp::registerApps();
}
