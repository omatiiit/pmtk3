function [logZ, nodeBels, clqBels, cliqueLookup] = libdaiJtree(tfacs)
%% Bare bones interface to libdai's jtree algorithm 
% 
%% Input
%
% tfacs     - a cell array of tabular factors
%
%% Outputs
%
% logZ     - log of the partition sum
%
% nodeBels - all single marginals (node beliefs)
%
% clqBels  - all of the clique beliefs
%
% cliqueLookup - an nvars-by-ncliques lookup table
%%
[logZ, nodeBels, clqBels, cliqueLookup] = libdaiInfer(tfacs, 'JTREE', '[updates=HUGIN]');
end