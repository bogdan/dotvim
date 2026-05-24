local ls = require("luasnip")
local s, i, t, f, d, sn = ls.snippet, ls.insert_node, ls.text_node, ls.function_node, ls.dynamic_node, ls.snippet_node
local h = require("snippet_helpers")

local function dflt(n, fn)
  return d(n, function() return sn(nil, { i(1, fn()) }) end)
end

return {
  s("class", {
    t("class "), dflt(1, h.class_name), t({ "", "  " }), i(2), t({ "", "end" }),
  }),
  s("classe", {
    t("class "), dflt(1, h.class_name), t(" < "), i(2), t({ "", "end" }),
  }),
  s("job", {
    t("class "), dflt(1, h.class_name), i(2),
    t({ "", "", "  @queue = :" }), i(3, "low"),
    t({ "", "", "  def self.perform" }), i(4),
    t({ "", "", "end" }),
  }),
  s("mod", {
    t("module "), dflt(1, h.class_name), t({ "", "\t" }), i(2), t({ "", "end" }),
  }),
  s("module", {
    t("module "), dflt(1, h.class_name), t({
      "", "",
      "\tdef self.included(base)",
      "\t\tbase.extend         ClassMethods",
      "\t\tbase.class_eval do",
      "\t\t  ",
    }), i(2), t({
      "", "\t\tend",
      "\tend # self.included",
      "",
      "\tmodule ClassMethods",
      "",
      "\tend # ClassMethods",
      "",
      "end",
    }),
  }),
  s("bt", {
    t("belongs_to :"), i(1, "association"), t(", inverse_of: :"), dflt(2, h.factory_name),
  }),
  s("admcont", {
    t("class Admin::"), dflt(1, h.class_name), t({
      " < Admin::BaseController",
      "\tdef index",
      "\t\t@grid = ",
    }), i(2), t({
      ".new(params[:g]) do |scope|",
      "\t\t\tscope.page(params[:page])",
      "\t\tend",
      "\tend",
      "end",
    }),
  }),
  s("hm", {
    t("has_many :"), i(1), t(", dependent: :destroy, inverse_of: :"), dflt(2, h.factory_name),
  }),
  s("migration", {
    t("class "), dflt(1, h.migration_name), t({
      " < ActiveRecord::Migration",
      "\tdef self.up",
      "\t\t",
    }), i(2), t({
      "", "\tend",
      "", "\tdef self.down",
      "\tend",
      "end",
    }),
  }),
  s("desc", {
    t({ "require 'spec_helper'", "", "describe " }), dflt(1, h.spec_name),
    t({ " do", "\t" }), i(2), t({ "", "end" }),
  }),
  s("desm", {
    t({ "require 'spec_helper'", "", "describe " }), dflt(1, h.spec_name),
    t({ " do", "  ", "\tsubject { build(:" }), dflt(2, h.factory_name),
    t({ ") }", "", "\tit {should be_valid}", "", "end" }),
  }),
  s("fc",   { t("create(:"), dflt(1, h.factory_name), t(", "), i(2), t(")") }),
  s("fcat", { t("attributes_for(:"), dflt(1, h.factory_name), t(")") }),
  s("fcb",  { t("build(:"), dflt(1, h.factory_name), t(")") }),
  s("fcc",  { t("create(:"), dflt(1, h.factory_name), t(")") }),
  s("tcl", {
    t({ "require 'test_helper'", "", "class " }), dflt(1, h.class_name),
    t({ " < ActiveSupport::TestCase", "  " }), i(2), t({ "", "end" }),
  }),
}
