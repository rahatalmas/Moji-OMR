import 'package:flutter/material.dart';


class Create extends StatelessWidget{
  const Create({super.key});

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
             padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
             decoration: BoxDecoration(
                color: Colors.green[100],
               borderRadius: const BorderRadius.all(Radius.circular(10)),
               border: Border.all(color: Colors.black87,width: 2)
             ),
            child: const Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.question_answer_outlined),
                        Text("Question Maker",style: TextStyle(fontSize: 17),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Edit",style: TextStyle(fontSize: 17),),
                        Icon(Icons.settings,size: 20,)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Total: 10"),
                    SizedBox(width: 20,),
                    Text("Added: 7"),
                    SizedBox(width: 20,),
                    Text("Remaining: 3")
                  ],

                ),
                SizedBox(height: 2,),
                Row(
                  children: [
                    Text("Options per Question: 4"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              //margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
              decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Question- 1",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 2,),
                  const Text("Type Your Question",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  const CustomTextField(hintText: "Type Question",prefixIcon: Icons.question_mark,labelText: "Question",),
                  const SizedBox(height: 10,),

                  const Text("Type Options",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  const CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option A",),

                  const SizedBox(height: 10,),
                  const CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option B",),

                  const SizedBox(height: 10,),
                  const CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option C",),

                  const SizedBox(height: 10,),
                  const CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option D"),

                  const SizedBox(height: 15,),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black87,width: 2)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          /*ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:10,
              itemBuilder: (context, index) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                    decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Question- 1",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                        SizedBox(height: 2,),
                        Text("Type Your Question",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: "Type Question",prefixIcon: Icons.question_mark,labelText: "Question",),
                        SizedBox(height: 10,),

                        Text("Type Options",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option A",),

                        SizedBox(height: 10,),
                        CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option B",),

                        SizedBox(height: 10,),
                        CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option C",),

                        SizedBox(height: 10,),
                        CustomTextField(hintText: "Enter text here",prefixIcon: Icons.circle,labelText: "Option D"),
                      ],
                    )
                );
              },
          )*/
        ],
      )
    );
  }
}




// struct later


class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final String labelText;

  const CustomTextField({
    required this.hintText,
    required this.prefixIcon,
    this.labelText = '',
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(widget.prefixIcon,size: 10,),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            errorText: _errorText,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                _errorText = 'This field is required';
              });
            } else {
              setState(() {
                _errorText = null;
              });
            }
          },
        ),
      ],
    );
  }
}
