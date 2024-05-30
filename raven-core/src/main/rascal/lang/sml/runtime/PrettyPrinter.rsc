module lang::sml::runtime::PrettyPrinter

import lang::sml::model::Model;
import lang::sml::runtime::Model;
import lang::raven::Env;
import Map;

public str print(Env env, machInst(UUID miid, UUID mid, UUID cur,  map[UUID sid, UUID siid] sis)) =
  "machine instance <getMach(env, mid).name>
  '  <for(siid <- range(sis)){><print(env, getStateInst(env, siid))><if(cur == siid){> (*)<}>
  <}>";

public str print(Env env, stateInst(UUID siid, UUID sid, int count)) =
  "state <getState(env, sid).name>: <count>";