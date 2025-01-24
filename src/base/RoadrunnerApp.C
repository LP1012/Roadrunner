#include "RoadrunnerApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
RoadrunnerApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

RoadrunnerApp::RoadrunnerApp(InputParameters parameters) : MooseApp(parameters)
{
  RoadrunnerApp::registerAll(_factory, _action_factory, _syntax);
}

RoadrunnerApp::~RoadrunnerApp() {}

void
RoadrunnerApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAllObjects<RoadrunnerApp>(f, af, syntax);
  Registry::registerObjectsTo(f, {"RoadrunnerApp"});
  Registry::registerActionsTo(af, {"RoadrunnerApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
RoadrunnerApp::registerApps()
{
  registerApp(RoadrunnerApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
RoadrunnerApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  RoadrunnerApp::registerAll(f, af, s);
}
extern "C" void
RoadrunnerApp__registerApps()
{
  RoadrunnerApp::registerApps();
}
