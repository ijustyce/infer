(*
* Copyright (c) 2013 - Facebook. All rights reserved.
*)

(** Eradicate NPEs. *)

val callback_eradicate : Callbacks.proc_callback_t

val callback_check_return_type : TypeCheck.check_return_type -> Callbacks.proc_callback_t


(** Parameters of a call. *)
type parameters = (Sil.exp * Sil.typ) list


(** Type for a module that provides a main callback function *)
module type CallBackT =
sig
  val callback :
  TypeCheck.checks -> Procname.t list -> TypeCheck.get_proc_desc ->
  Idenv.t -> Sil.tenv -> Procname.t ->
  Cfg.Procdesc.t -> unit
end (* CallBackT *)


(** Extension to the type checker. *)
module type ExtensionT = sig
  type extension
  val ext : extension TypeState.ext
  val mkpayload : extension TypeState.t option -> Specs.payload
end

(** Given an extension to the typestate with a check, call the check on each instruction. *)
module Build (Extension : ExtensionT) : CallBackT
